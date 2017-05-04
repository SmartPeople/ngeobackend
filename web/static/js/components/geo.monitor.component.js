import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';
import { Connection } from './geo.monitor.service';
import { apiKey } from './apikey.js';


function round(val) {
    return Math.round(val*100)/100;
}

function getMapHeight() {
    return (window.innerHeight - window.innerHeight/5).toString() + 'px';
}

const style = {
    geoMonitor : {
        position: 'relative',
        height : getMapHeight(),
    },
    geoMap : {
        position: 'absolute',
        width   : '100%',
        height  : '100%',
        display : 'block'
    },
    list : {
        overflow    : 'auto',
        position    : 'absolute',
        top         : '10px',
        maxHeight   : '90%',
        width       : '280px',
        border      : '1px solid #ccc',
        borderRadius: '4px',
        backgroundColor: 'rgba(254,254,254, 0.7)'
    },
    obj : {
        position: 'absolute',
        top     : '10px',
        right   : '4px',
        width   : '260px',
    },
    ul : {
        listStyle: 'none',
        padding  : 0
    },
    li : {
        cursor : 'pointer'
    },
    //TODO: Position of the pin might be wrong!
    pin : {
        width    : '52px',
        marginTop: '-36px'
    }
};

const AnyReactComponent = () => <div> <img style={style.pin} src="/images/location_marker_thumb.png" /> </div>;

const Map = (props) => {
    const msg = props.position.body,
          pos = msg.coords || msg.location.coords;
    return (
        <GoogleMapReact 
            bootstrapURLKeys={{ key: apiKey.key }}
            center={{lat: pos.latitude, lng: pos.longitude}}
            defaultZoom={16}
        >
            <AnyReactComponent
                lat={pos.latitude}
                lng={pos.longitude}
            />
        </GoogleMapReact>
    );
}

export class GeoMonitor extends Component {

    constructor(props) {
        super(props);
        this.connection = new Connection(userToken, 'geo:data', 'geo:new');
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
        const msg = event.body;
        if(msg.coords || msg.location) {
            const coords = msg.coords || msg.location.coords;
            return [
                msg.timestamp
                // round(coords.latitude),
                // round(coords.longitude),
                // round(coords.altitude)
                ].join(', ');
        } else {
            return msg.message ? msg.message : 'Look at object';
        }


    }

    render() {
        const list = this.state.list,
              show = JSON.stringify(this.state.show, null, 2);
        console.log(this.state.show);
        return (
            <div className="geo-monitor" style={style.geoMonitor}>
                <div className="map" style={style.geoMap}>
                     {(this.state.show && (this.state.show.body.type === 0 || this.state.show.body.type === 2)) ? (<Map position={this.state.show}/>) : ('')}
                </div>
                <div className="list" style={style.list}>
                    <ul style={style.map}>
                        {list.map((event, i) =>
                            <li key={i} onClick={() => this.setShow(i)} style={style.li}>
                                <strong>{event.user}:</strong> {this.lineBody(event)}
                            </li>
                        )}
                    </ul>
                </div>
                <div className="obj"  style={style.obj}><pre style={{backgroundColor: 'rgba(254,254,254, 0.7)'}} >{show}</pre></div>
            </div>
        );
    }
}