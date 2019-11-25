This project is deprecated, please use DropletKit, the the official DigitalOcean API client for Ruby - https://github.com/digitalocean/droplet_kit


# colombo [![Gem Version](https://badge.fury.io/rb/colombo.png)](http://badge.fury.io/rb/colombo) [![Dependency Status](https://gemnasium.com/lmmendes/colombo.png)](https://gemnasium.com/lmmendes/colombo) [![Code Climate](https://codeclimate.com/github/lmmendes/colombo.png)](https://codeclimate.com/github/lmmendes/colombo)


A simple Digital Ocean (http://digitalocean.com) API wrapper

## Install

```
gem install colombo
```

## Examples

### Configuration

```ruby
# You can set Columbus configuration at class level like so
Colombo.configure do |c|
  c.api_key   = ENV['DO_API_KEY']
  c.client_id = ENV['DO_CLIENT_ID']
end

# Or configure each instance independently
@client = Colombo.new(
  :api_key   => ENV['DO_API_KEY'],
  :client_id => ENV['DO_CLIENT_ID']
)
```

### Droplets

```ruby

# This method returns all active droplets that are currently running in your account
@client.droplets()

# This method returns a specfic droplet (via droplet_id)
# without having to fetch all droplets first
@client.droplet( droplet_id )

# This method returns full information for a specific droplet ID
@client.droplets.find( droplet_id )

# This method allows you to create a new droplet.
new_droplet = droplets.create({
  :name       => COLOMBO_DROPLET_NAME  ,
  :image_id   => COLOMBO_IMAGE_ID      ,
  :region_id  => COLOMBO_REGION_ID     ,
  :size_id    => COLOMBO_SIZE_ID
})

# This method allows you to reboot a droplet.
# This is the preferred method to use if a server is not responding.
@client.droplets.find( droplet_id ).reboot()

# This method allows you to power cycle a droplet.
# This will turn off the droplet and then turn it back on.
@client.droplets.find( droplet_id ).power_cycle()

# This method allows you to shutdown a running droplet.
# The droplet will remain in your account.
@client.droplets.find( droplet_id ).shutdown()

# This method renames the droplet to the specified name (new_droplet_name).
@client.droplets.find( droplet_id ).rename( new_droplet_name )


```

### Regions
```ruby
# Return all the available regions within the Digital Ocean cloud.
@client.regions
```

### Images
```ruby
# This method returns all the available images that can be accessed by your
# client ID. You will have access to all public images by default, and any
# snapshots or backups that you have created in your own account.
@client.images

# Takes the optional parameter filter, either :my_images or :global
@client.images(:filter => :my_images)

# This method displays the attributes of an image.
@client.images.find(image_id)

# This method allows you to transfer an image to a specified region.
@client.images.find(image_id).transfer( new_region_id )


# This method allows you to destroy an image. There is no way to restore a
# deleted image so be careful and ensure your data is properly backed up.
# NOTE: You need to pass true to the destroy method to ensure that you know
# what you are doing.
@client.images.find( image_id ).destroy(true)
```

### SSH Keys
```ruby
# This method lists all the available public SSH keys in your account
# that can be added to a droplet.
@client.ssh_keys

# Shows a specific public SSH key in your account that can be added to a droplet.
@client.find( ssh_key_id )

# This method allows you to add a new public SSH key to your account.
ssh_key = @client.ssh_keys.create({
  :name        => 'my ssh key name',
  :ssh_pub_key => 'my ssh key ...'
})

# This method allows you to modify an existing public SSH key in your account.
ssh_key.update(:ssh_pub_key => 'my new ssh key')

# This method will delete the SSH key from your account.
ssh_key.destroy

```

### Sizes
```ruby
# This method returns all the available sizes that can be used to create a droplet.
@client.sizes
```

### Events
```ruby
# This method is primarily used to report on the progress of an event
# by providing the percentage of completion.
@client.event( event_id )
```



## Bug reports and other issues

* https://github.com/lmmendes/colombo/issues

## Help and Docs

* https://github.com/lmmendes/colombo/wiki

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Send me a pull request. Bonus points for topic branches.

## License

Colombo is free software distributed under the terms of the MIT license reproduced [here](http://opensource.org/licenses/mit-license.html).

