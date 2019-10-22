import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng startingLocation;
  final bool selecting;

  MapScreen({this.selecting = true, this.startingLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  void initState() {
    if (widget.startingLocation != null) {
      _pickedLocation = widget.startingLocation;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          widget.selecting
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        })
              : Container()
        ],
        backgroundColor: const Color(0xFFB96B40),
        title: Text(
          widget.selecting ? 'Chagua Eneo' : 'Eneo La Tukio',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: widget.startingLocation, zoom: 16),
              onTap: widget.selecting ? _selectLocation : null,
              markers: _pickedLocation == null
                  ? null
                  : {Marker(markerId: MarkerId('m1'), position: _pickedLocation)},
            ),
          ),
          widget.selecting
              ? RaisedButton.icon(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  icon: Icon(Icons.check),
                  color: const Color(0xFFB96B40),
                  elevation: 0,
                  label: Text('Kamilisha'),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        })
              : Container()
        ],
      ),
    );
  }
}
