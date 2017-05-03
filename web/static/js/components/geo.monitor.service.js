import { Socket } from "phoenix";

export class Connection {

    socket;
    channel;
    channelName;
    msgName;
    callback;

    constructor(userToken, channelName, msgName) {
        
        this.userToken   = userToken;
        this.channelName = channelName;
        this.msgName     = msgName;
        console.log(this.userToken); 
        this.socket = new Socket("/socket", {
            params: {token: this.userToken}
            // logger: ((kind, msg, data) => { console.log(`${kind}: ${msg}`, data) })
        });
    }

    mount() {

        this.socket.connect();
        this.socket.onOpen( ev => console.log("OPEN", ev) )
        this.socket.onError( ev => console.log("ERROR", ev) )
        this.socket.onClose( e => console.log("CLOSE", e))

        this.channel = this.socket.channel(this.channelName, {});
        this.channel.join()
            .receive("ignore", () => console.log("auth error"))
            .receive("ok", (msg) => console.log(msg));

        this.channel.onError(e => (msg) => console.log(msg))
        this.channel.onClose(e => (msg) => console.log(msg))
        this.channel.on(this.msgName, (msg) => {
            if(this.callback) {
                this.callback(msg);
            }
        });
        return this;
    }

    unmount() {
        this.callback = null;
        this.channel.leave();
        this.socket.disconnect();
        return this;
    }

    onmessage(callback) {
        this.callback = callback;
        return this;
    }
}