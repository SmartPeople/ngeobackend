import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';
import { Connection } from './geo.monitor.service';
import { apiKey } from './apikey.js';

const style = {
    geoMonitor : {
        display       :'flex',
        flexDirection : 'row',
        justifyContent: 'space-between'
    },
    geoMap: {
        width: 400,
        height: 400,
        display: 'block'
    }
};

const AnyReactComponent = ({ text }) => <div>{text}</div>;

class Map extends Component {

    render() {
        const position = this.props.position.body.coords;
        console.log(position);
        return (
            <GoogleMapReact 
                bootstrapURLKeys={{ key: apiKey.key }}
                center={{lat: position.latitude, lng: position.longitude}}
                defaultZoom={16}
            >
                <AnyReactComponent
                    lat={59.955413}
                    lng={30.337844}
                    text={'Kreyser Avrora'}
                />
            </GoogleMapReact>
        );
    }
}

export class GeoMonitor extends Component {

    constructor(props) {
        super(props);
        this.connection = new Connection('123', 'geo:data', 'geo:new');
        this.state = {
            list: [],
            show : null
        };
        this.LIMIT = 100;
    }

    componentDidMount() {
        this.connection
            .mount()
            .onmessage((msg => {
                this.setState((prev) => {
                    const list = prev.list.slice(0, this.LIMIT - 1);
                    list.unshift(msg);
                    const out = {list: list}
                    if (!this.state.show) {
                        out["show"] = list[0];
                    }
                    return out;
                });
            }));
    }

    componentWillUnmount() {
        this.connection.unmount();
    }

    setShow(i) {
        this.setState({show: this.state.list[i]});
    }

    render() {
        const list = this.state.list,
              show = JSON.stringify(this.state.show, null, 4);
        return (
            <div className="geo-monitor" style={style.geoMonitor}>
                <div className="list">
                    <ul>
                        {list.map((event, i) =>
                            <li key={i} onClick={() => this.setShow(i)}>
                                {event.user}: {event.body.uuid}
                            </li>
                        )}
                    </ul>
                </div>
                <div className="map" style={style.geoMap}>
                     {this.state.show ? (<Map position={this.state.show}/>) : ('')}
                </div>
                <div className="obj"><pre>{show}</pre></div>
            </div>
        );
    }
}