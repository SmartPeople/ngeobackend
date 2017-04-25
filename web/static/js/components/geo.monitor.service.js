import { Socket } from "phoenix";

export class Connection {

    socket;
    channel;
    user;
    channelName;
    msgName;
    callback;

    constructor(user, channelName, msgName) {
        
        this.user        = user;
        this.channelName = channelName;
        this.msgName     = msgName;

        this.socket = new Socket("/socket", {
            // params: {token: window.userToken}
            // logger: ((kind, msg, data) => { console.log(`${kind}: ${msg}`, data) })
        });
    }

    mount() {

        this.socket.connect({user_id: this.user});
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