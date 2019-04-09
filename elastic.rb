require 'elasticsearch'

client = Elasticsearch::Client.new url: 'http://localhost:9200', log:true

#client.transport.reload_connections!
#client.cluster.health
#client.index index: 'addresses', type: 'address', body:{city: 'Praha', street: 'Ulcova'}


client.search index: 'addresses', body: {query: {match:{city: 'Praha'}}}


