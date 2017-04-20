import React, { Component } from 'react';
import { apiKey } from './apikey.js';
import GoogleMapReact from 'google-map-react';

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
        return (
            <GoogleMapReact 
                bootstrapURLKeys={{key:'AIzaSyDC13MzYSjbKUPn_MW-Q4b79GxrOPiYDzk'}}
                defaultCenter={{lat: 59.95, lng: 30.33}}
                defaultZoom={11}
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
    render() {
        return (
            <div className="geo-monitor" style={style.geoMonitor}>
                <div className="list">
                    <ul>
                        <li>List will be here</li>
                    </ul>
                </div>
                <div className="map" style={style.geoMap}>
                     <Map/>
                </div>
                <div className="obj"><pre>JSON object will be here!</pre></div>
            </div>
        );
    }
}