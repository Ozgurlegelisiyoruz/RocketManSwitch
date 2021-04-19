using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace color
{
    [System.Serializable]
    public class ColorTypeInfo
    {
        public ColorName ColorName;
        public Material ColorMaterial;
        public Material ColorTrans;
        public ColorTypeInfo(ColorName colorName, Material colorMaterial)
        {
            ColorName = colorName;
            ColorMaterial = colorMaterial;
        }
    }
    [System.Serializable]
    public enum ColorName
    {
        Red,
        Green,
        Yellow
    }
}
