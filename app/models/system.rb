class System < ActiveRecord::Base
	belongs_to :allegiance, inverse_of: :systems
	belongs_to :government, inverse_of: :systems

	has_many :stations, inverse_of: :system

	validates :allegiance, presence: true
	validates :government, presence: true
	validates :name, presence: true, uniqueness: true
	# eds_id
	# x,y,z

	def update_eds_coordinates

		puts "In update_eds_coordinates"
		system_id = id
		puts "id = #{id}"
		puts "name = #{name}"

		require "uri"
		require "net/http"

		uri = URI.parse('http://edstarcoordinator.com/api.asmx/GetSystems')
		# uri = URI('http://edstarcoordinator.com/api.asmx/GetSystems')
		# uri = URI('http://www.example.com/todo.cgi')

		# uri = URI.parse('http://www.edstarcoordinator.com/api.asmx/GetSystems')

		# http = Net::HTTP.new(uri.host,uri.port)
		# https.use_ssl = true

		data = {
			'data' => {
				'ver' => 2,
				'test' => true,
				'outputmode' => 1,
				'filter' => {
					'knownstatus' => 1,
					'systemname' => name,
					'cr' => 5,
					'coordcube' => [[-0,0],[-0,0],[-0,0]]
				}
			}
		}

		puts data

		# uri = URI.parse("http://www.edstarcoordinator.com/api.asmx/GetSystems?#{data.to_json}&content=application/json; charset=utf-8")

		http = Net::HTTP.new(uri.host,uri.port)

		# url_string = "?data=#{data.to_json}&content=application/json; charset=utf-8"
		# puts "url string:"
		# puts url_string

		puts "uri path:"
		puts uri.path
		pp uri

		request = Net::HTTP::Post.new(uri.path)
		# request.type = 'json'
		request.set_form_data(data)
		# request.content_type = 'application/json; charset=utf-8'

		response = Net::HTTP.start(uri.host, uri.port) do |http|
		  http.request(request)
		end

		# pp request

		# response = http.request(request)
		# pp response

		case response
			when Net::HTTPSuccess, Net::HTTPRedirection
			  puts response.body
			else
			  puts response.value
		end






# url = URI.parse('http://www.edstarcoordinator.com/api.asmx/GetSystems')
# req = Net::HTTP::Post.new(url.to_s)

# res = Net::HTTP.start(url.host, url.port) {|http|
#   http.request(req)
# }
# puts res.body


# function getSystemData(){
# //var data = {data: {ver:2}}; //Just one required parameter - Simplest possible
# var data = {
#   data: {
#     ver:2,
#     test: true,
#     outputmode:1,
#     filter:{
#         knownstatus:0,
#         systemname: "sol",
#         cr:5,
#         date:"2014-09-18 12:34:56",
#         coordcube: [[-10,10],[-10,10],[-10,10]],
#         coordsphere: {radius: 123.45, origin: [10,20,30]}
#     }
#   }
# };

# $.ajax({
#   type: 'POST',
#   contentType: 'application/json; charset=utf-8',
#   url: 'api.asmx/GetSystems',
#   data: JSON.stringify(data),
#   dataType: 'json',
#   success:
#     function(data){
#       submitsuccess(data.d);
#     },
#   error: submiterror
# });
# };

# type: 'POST'
# contentType: 'application/json; charset=utf-8'


# GetSystems
# Get a list of systems

# Request

# Method  URL
# POST    api.asmx/GetSystems
# TYPE    Params                  Values
# POST    ver                     int (>=1)
# POST    test                    bool        [Optional][Default:false]
# POST    outputmode              int (1/2)   [Optional][Default:1]
# POST    filter                  Object containing all filter options [Optional]
# POST    knownstatus [filter]    int (0/1/2) [Optional][Default:0]
# POST    systemname [filter]     string [Optional]
# POST    cr [filter]             int (>=0) [Optional][Default:5]
# POST    date [filter]           "yyyy-MM-dd hh:mm:ss" || "yyyy-MM-dd" [Optional][Default: Now-24h]
# POST    coordcube [filter]      [[xmin,xmax][ymin,ymax][zmin,zmax]] [Optional] min is inclusive ">=", max is exlusive "<"
# POST    coordsphere [filter]    {radius:xxx.xx, origin:[x,y,z]} [Optional] radius is inclusive ">="


# ver
# ver must be send with all requests. Only the Major version number.
# Minor version numbers of the API are always backwards compatible with the Major version.

# test
# When test is true all queries are directed at a test DB.
# The test DB is a mirror of the non-test DB and is beeing mirrored every 24 hours at 1:15 UTC
# Please use the test flag when developing your apps, so we get as little trash as possible in the non-test DB.

# outputmode
# outputmode can be used to reduce bandwidth, as not all possible info is always required. A simple (Terse) list of names is fine for a dropdown list.
# 1 (Terse) - Returns only the names of the systems
# 2 (Verbose) - Returns id, name, coords, cr, who and when created/updated the system last.

# filter
# filter is an object wrapping the individual filter options

# knownstatus
# knownstatus filters on if a systems coordinates are known or not
# 0 (All) Default - Returns all systems, ie. "no filter".
# 1 (Known) - Returns only systems with known coordinates.
# 2 (Unknown) - Returns only systems not having known coordinates.

# systemname
# systemname Limit search to systems with names containing systemname

# cr
# cr Confidence Rating. How many times have an entry been confirmed.
# With a cr of 1 it could be a mis-typed system name. The chance of which is reduced with a higher cr number. Records with a cr equal or higher than the supplied value are returned.

# date
# date Date of last update.
# date is an UTC date.
# Records with an update date equal or higher than date are returned.
# Suggested use is to keep note of your last pull, and then only request records newer than that timestamp.

# coordcube
# coordcube limits the results to those starsystems contained by the defined cube

# coordsphere
# coordsphere Limits the result to those starsystems within the given radius of the origin

# Example code

# Code example
# Complete copy/paste ready code (Requires jQuery) - JSFiddle

# function getSystemData(){
# //var data = {data: {ver:2}}; //Just one required parameter - Simplest possible
# var data = {
#   data: {
#     ver:2,
#     test: true,
#     outputmode:1,
#     filter:{
#         knownstatus:0,
#         systemname: "sol",
#         cr:5,
#         date:"2014-09-18 12:34:56",
#         coordcube: [[-10,10],[-10,10],[-10,10]],
#         coordsphere: {radius: 123.45, origin: [10,20,30]}
#     }
#   }
# };

# $.ajax({
#   type: 'POST',
#   contentType: 'application/json; charset=utf-8',
#   url: 'api.asmx/GetSystems',
#   data: JSON.stringify(data),
#   dataType: 'json',
#   success:
#     function(data){
#       submitsuccess(data.d);
#     },
#   error: submiterror
# });
# };

# function submitsuccess(data){}

# function submiterror(d,a){}






# An example response is:-
#   {
#     ver: 2.0,
#     date: "2014-11-08 19:57:37",
#     status: {
#       input: [
#         {
#           status: {
#             statusnum: 0,
#             msg: "Success"
#           }
#         }
#       ]
#     },
#     systems: [
#       {
#         id: 222,
#         name: "10 Canum Venaticorum",
#         coord: [
#           -9.375,
#           55.4375,
#           -7
#         ],
#         cr: 5,
#         commandercreate: "",
#         createdate: "2014-11-07 13:38:07",
#         commanderupdate: "",
#         updatedate: "2014-11-07 13:38:07"
#       },
#       {
#         id: 254,
#         name: "10 Ursae Majoris",
#         coord: [
#           0.03125,
#           34.90625,
#           -39.09375
#         ],
#         cr: 5,
#         commandercreate: "",
#         createdate: "2014-11-07 13:38:07",
#         commanderupdate: "",
#         updatedate: "2014-11-07 13:38:07"
#       },
#     ...
# }
	end
end
