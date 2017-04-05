SuperDirt.start;


(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 32; // increase this if you need to load more samples
s.options.memSize = 8192 * 32; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 64; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numWireBufs = 1024*8;
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2; // set this to your hardware input channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	s.sync; // wait for samples to be read
	~dirt.start(57120, [0, 0]);   // start listening on port 57120, create two orbits, each sending audio to channel 0. You can direct sounds to the orbits from tidal e.g. by: `# orbit "0 1 1"
}
)
// now you should be able to send from tidal via port 57120

s.dumpOSC;

SynthDef("testsynth", {
	arg out;
	var sound = SinOsc.ar(440.0);
	OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, 0.5));
}).add;
