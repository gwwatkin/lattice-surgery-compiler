from fractions import Fraction
import math


def decompose_pi_fraction(f:Fraction):
  """
  Break a fraction that has a power of two as denominator into a sequence of fractions 
  that add up to it, all of which have 1 for numerator.

  Adjusts the fraction to be in the (2,0] range
  """

  # Check that f's denominator is a power of two
  assert(f.denominator & (f.denominator - 1) == 0)

  # Adjust to the the (2*pi,0] range
  f = Fraction(f.numerator % (2*f.denominator), f.denominator)

  if f.numerator == 0: return [f]
  elif f.numerator == 1: return [f]
  else:
      p = int(math.log(f.numerator, 2))
      largest_pow_of_2 = int(pow(2, p))  
      return [Fraction(largest_pow_of_2, f.denominator)] \
        + decompose_pi_fraction(Fraction(f.numerator - largest_pow_of_2,f.denominator))


def phase_frac_to_latex(phi : Fraction):
  """Assumes phi is multiplied by pi"""
  if phi.numerator== 0: return "0"

  sign = "" if phi.numerator > 0 else "-"
  num = "" if abs(phi.numerator) == 1 else str(abs(phi.numerator))

  if phi.denominator == 1:
    return "%s%s\\pi"%(sign,num)

  den = str(phi.denominator)

  return "%s\\frac{%s\\pi}{%s}"%(sign,num,den)
