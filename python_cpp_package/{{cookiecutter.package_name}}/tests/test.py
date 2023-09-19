import unittest

import numpy as np
import {{cookiecutter.package_name}}

class TestLinearAlgebra(unittest.TestCase):
    def test_det(self):
        a = np.array([[1, 0.1], [0.1, 1]])
        det = {{cookiecutter.package_name}}.det(a)
        self.assertEqual(det, 0.99, "0.99")

if __name__ == '__main__':
    unittest.main()
