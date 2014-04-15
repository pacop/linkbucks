# Linkbucks

Unofficial API Wrapper for Linkbucks.com

[![Build Status](https://travis-ci.org/pacop/linkbucks.svg?branch=master)](https://travis-ci.org/pacop/linkbucks)

## Installation

To use this rubygem:

```
$ sudo gem install linkbucks
```

With bundler:

```
gem "linkbucks", "~> 0.0.2"
```

## Some examples
  
```  
linkbucks = Linkbucks::API.new USER, PASSWORD
linkbucks.create_link_single originalLink: 'http://www.google.es'
=> {"linkId"=>82924, "link"=>"http://www.linkbucks.com/987d3"}
```

You can specify adType or contentType

```
linkbucks.create_link_single originalLink: 'http://www.google.es', adType: :intermission, contentType: :clean
```

## Contributing to linkbucks
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.


## Copyright

Copyright (c) 2014 pacop. See LICENSE.txt for
further details.
