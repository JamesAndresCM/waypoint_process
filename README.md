# WaypointsProcessApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * [Front end](https://github.com/JamesAndresCM/waypoint_proccess_front_end)

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Endpoints
### Post Waypoint
* http://localhost:4000/api/v1/waypoints
* Payload: 
````
{
   "waypoint":{
      "driver_id":1,
      "account_id":1,
      "coordinates":{
         "latitude":-790,
         "longitude":200
      }
   }
}
````

### Show Waypoints for driver 
* http://localhost:4000/api/v1/waypoints?driver_id=1 
* (also permit page param for pagination &page=)

## Show Waypoint
* http://localhost:4000/api/v1/waypoints/409
