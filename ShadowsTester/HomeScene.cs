﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Threading.Tasks;
using VEngine;
using VEngine.Generators;
using OpenTK;

namespace ShadowsTester
{
    public class HomeScene : Scene
    {
        public HomeScene()
        {
            var testroom = Object3dInfo.LoadSceneFromObj(Media.Get("testroom.obj"), Media.Get("testroom.mtl"), 3.0f);
            //var instances = InstancedMesh3d.FromMesh3dList(testroom);
            foreach(var ob in testroom)
            {
                ob.SetMass(0);
                ob.SetCollisionShape(ob.MainObjectInfo.GetAccurateCollisionShape());
                this.Add(ob);
            }
        }

    }
}
