# Chef / Engine Yard REE

A chef-solo repo for setting up Ruby Enterprise Edition on a conventional Engine Yard slice. (Not within their new cloud offering.) Why REE? Primarily for tune-able garbage collection, among other benefits. Why a chef recipe? Because you might have more than one slice. Inspired and lifted in part from Weplay/Luke Melia, Twitter/Evan Weaver, Chris Heald and others:

* [http://www.lukemelia.com/blog/archives/2009/10/08/running-ree-at-engineyard/](http://www.lukemelia.com/blog/archives/2009/10/08/running-ree-at-engineyard/)
* [http://blog.evanweaver.com/articles/2009/09/24/ree/](http://blog.evanweaver.com/articles/2009/09/24/ree/)
* [http://www.coffeepowered.net/2009/06/13/fine-tuning-your-garbage-collector/](http://www.coffeepowered.net/2009/06/13/fine-tuning-your-garbage-collector/)

WARNING: This recipe is customized for my needs.  In particular, specific gems are used and the recipe is designed for applications running on thins (instead of mongrels.) Also note that as of now, Engine Yard does not officially support REE. (They are good folks though - file a ticket and let them know you are using it.) AS IS. Fork, modify accordingly, and use at your own risk.   

## Usage

Edit dna.json.

From your EY slice:

    cd ~ && git clone <your forked version of this recipe> && cd chef-ey-ree
    sudo ./bootstrap.sh
    
Flip between mri and ree: (probably best to do this with all of your slices via `cap shell`)

    ./eyruby_switch ree
    
And back:

    ./eyruby_switch mri
    
## GC Tuning
    
Edit `/path/to/your/gc_params.yml`
Then bounce your thins.

## TODO

* Make a little less brute-forcey

## License

MIT
