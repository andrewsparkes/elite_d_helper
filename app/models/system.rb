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
