// Copyright (C) 2007 Michael Creel <michael.creel@uab.es>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, see <http://www.gnu.org/licenses/>.

// __kernel_weights: for internal use by kernel density and regression functions
// This function was originally written as .m file and eventually rewritten in
// C++ for performance. the .m file was removed from the package on revision
// 10407 by carandraug

#include <oct.h>
#include <octave/parse.h>

DEFUN_DLD(__kernel_weights, args, ,"__kernel_weights: for internal use by kernel_regression and kernel_density functions")
{

	Matrix data (args(0).matrix_value());
	Matrix evalpoints (args(1).matrix_value());
	std::string kernel (args(2).string_value());

	int n, nn, i, j, k, dim;

	n = data.rows();
	dim = data.columns();
	nn = evalpoints.rows();
	Matrix W(nn, n);
	Matrix zz(n,dim);
	Matrix zzz;
	octave_value kernelargs;
	octave_value_list f_return;

	for (i = 0; i < nn; i++) {
		for (j = 0; j < n; j++) {
			// note to self: zz.insert(data.row(j) - evalpoints.row(i), j, 0) is slower
			for (k = 0; k < dim; k++) {
				zz(j,k) = data(j,k) - evalpoints(i,k);
			}
		}
		kernelargs = zz;
		f_return = feval(kernel, kernelargs);
		zzz = f_return(0).matrix_value();

		// note to self: W.insert(zzz.transpose(),i,0) is slower
		for (j = 0; j < n; j++) {
			W(i,j) = zzz(j,0);
		}
	}
	f_return(0) = W;
	return f_return;
}
