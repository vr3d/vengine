﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenTK;

namespace VDGTech
{
    public static class MathExtensions
    {

        public static Vector3 ToOpenTK(this BEPUutilities.Vector3 v)
        {
            return new Vector3(v.X, v.Y, v.Z);
        }
        public static Quaternion ToOpenTK(this BEPUutilities.Quaternion q)
        {
            return q;
        }
        public static BEPUutilities.Vector3 ToBepu(this Vector3 v)
        {
            return new BEPUutilities.Vector3(v.X, v.Y, v.Z);
        }
        public static BEPUutilities.Quaternion ToBepu(this Quaternion q)
        {
            return q;
        }

        public static Vector3 ToDirection(this Quaternion quaternion)
        {
            return Vector3.Transform(-Vector3.UnitZ, quaternion);
        }

        public static Vector3 Rotate(this Vector3 vector, Quaternion quaternion)
        {
            return Vector3.Transform(vector, quaternion);
        }

        public enum TangentDirection
        {
            Up, Down, Left, Right
        }

        public static Vector3 GetTangent(this Quaternion quaternion, TangentDirection direction)
        {
            switch (direction)
            {
                case TangentDirection.Up: return Vector3.Transform(Vector3.UnitY, quaternion);
                case TangentDirection.Down: return Vector3.Transform(-Vector3.UnitY, quaternion);
                case TangentDirection.Left: return Vector3.Transform(Vector3.UnitX, quaternion);
                case TangentDirection.Right: return Vector3.Transform(-Vector3.UnitX, quaternion);
            }
            return Vector3.Zero;
        }
    }
}