cookbook_path    ["site-cookbooks", 'vendor-cookbooks']
node_path        "nodes"
data_bag_path    "data_bags"

knife[:berkshelf_path]     = "vendor-cookbooks"
knife[:cookbook_copyright] = 'Dan Olson'
knife[:cookbook_email]     = 'olson_dan@yahoo.com'

Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
