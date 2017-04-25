import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';
import { Connection } from './geo.monitor.service';
import { apiKey } from './apikey.js';


function round(val) {
    return Math.round(val*100)/100;
}

const style = {
    geoMonitor : {
        display       : 'flex',
        flexDirection : 'row',
        justifyContent: 'space-between',
        height        : '600px'
    },
    geoMap: {
        width  : '30%',
        height : '100%',
        display: 'block',
        margin : '0 4px'
    },
    list : {
        overflow: 'auto',
        height  : '100%'
    },
    obj : {
        height  : '100%'
    },
    ul : {
        listStyle: 'none',
        padding  : 0
    },
    li : {
        cursor: 'pointer'
    },
    pin : {
        width : '52px',
        marginTop: '-36px'
    }
};

const AnyReactComponent = () => <div> <img style={style.pin} src="/images/location_marker_thumb.png" /> </div>;

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
                    lat={position.latitude}
                    lng={position.longitude}
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

    lineBody(event) {
        if(event.body.coords) {
            const coords = event.body.coords;
            return [
                round(coords.latitude),
                round(coords.longitude),
                round(coords.altitude)
                ].join(', ');
        } else {
            return event.body.msg;
        }
    }

    render() {
        const list = this.state.list,
              show = JSON.stringify(this.state.show, null, 4);
        return (
            <div className="geo-monitor" style={style.geoMonitor}>
                <div className="list" style={style.list}>
                    <ul style={style.map}>
                        {list.map((event, i) =>
                            <li key={i} onClick={() => this.setShow(i)} style={style.li}>
                                {event.user}: {this.lineBody(event)}
                            </li>
                        )}
                    </ul>
                </div>
                <div className="map" style={style.geoMap}>
                     {this.state.show ? (<Map position={this.state.show}/>) : ('')}
                </div>
                <div className="obj"  style={style.obj}><pre>{show}</pre></div>
            </div>
        );
    }
}