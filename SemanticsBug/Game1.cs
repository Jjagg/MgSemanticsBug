using System;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace SemanticsBug
{
    public class Game1 : Game
    {
        [STAThread]
        static void Main()
        {
            using (var game = new Game1())
                game.Run();
        }
 
        Effect effect;
        Texture2D texture;
        VertexPositionColor[] vertices = {
            new VertexPositionColor(new Vector3(-1, 1, 0), Color.Green), 
            new VertexPositionColor(new Vector3(1, 1, 0), Color.Green), 
            new VertexPositionColor(new Vector3(-1, -1, 0), Color.Green), 
        };

        public Game1()
        {
            new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
        }

        protected override void LoadContent()
        {
            effect = Content.Load<Effect>("effect");
            texture = new Texture2D(GraphicsDevice, 1, 1);
            texture.SetData(new[] {Color.White.PackedValue});
        }

        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            effect.CurrentTechnique.Passes[0].Apply();
            GraphicsDevice.Textures[0] = texture;

            GraphicsDevice.DrawUserPrimitives(PrimitiveType.TriangleList, vertices, 0, 1);

            base.Draw(gameTime);
        }
    }
}
