% code copied by gunnar march 4, 2026

function [freq1,freq2,ratio] = two_fft_gungun(sig1,sig2,freq)

  % baud rate of 115200 corresponds to a sample rate of 1000
  Fs = 1000;
  % this is unused. blow it up?
  % T = 1/Fs;

  % length of signal
  % sig1 and sig2 are the same length
  L = length(sig1);

  % do fft
  sig1 = sig1 - mean(sig1);
  sig2 = sig2 - mean(sig2);
  X = fft(sig1);
  Y = fft(sig2);
  f = Fs*(0:(L/2))/L;

  % i have genuinely no idea why this is what you're supposed to do
  % idk what this does
  P2X = abs(X/L);
  P1X = P2X(1:floor(L/2)+1);
  P1X(2:end-1) = 2*P1X(2:end-1);
  P2Y = abs(Y/L);
  P1Y = P2Y(1:floor(L/2)+1);
  P1Y(2:end-1) = 2*P1Y(2:end-1);

  % refine the range to driving frequency?
  % disp(round(freq/f(2))-25);
  P1X = P1X(round(freq/f(2))-25:round(freq/f(2))+25);
  P1Y = P1Y(round(freq/f(2))-25:round(freq/f(2))+25);
  [freq1,~] = max(P1X);
  [freq2,~] = max(P1Y);
  % these are unused. blow them up.?
  % f1 = f(I1);
  % f2 = f(I2);
  ratio = freq2/freq1;

  % im doing this to not include their code for plotting and printing.
  % whats the point of a function if it just prints stuff and plots stuff? i want to be able to use the outputs for other things, not just print them out.
end