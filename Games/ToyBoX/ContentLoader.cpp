#include "ContentLoader.h"

ContentLoader::ContentLoader()
{
}

IAnimatedMeshSceneNode* ContentLoader::LoadModel(const c8 *filename, IrrlichtDevice *device)
{
	//Convert to stringc
	stringc fn(filename);
	IAnimatedMeshSceneNode *node = 0;
	ISceneManager* smgr = device->getSceneManager();

	IAnimatedMesh* mesh = smgr->getMesh( fn.c_str() );

	//If the mesh can't be created
	if (!mesh)
	{
		//Display error message
		device->getGUIEnvironment()->addMessageBox(L"ToyBox", 
			L"The model could not be loaded. " \
			L"Maybe it is not a supported file format.");
		return 0;
	}

	// set default material properties
	node = smgr->addAnimatedMeshSceneNode(mesh);
	node->setMaterialFlag(EMF_LIGHTING, false);
	node->setMaterialFlag(EMF_BACK_FACE_CULLING, false);
	node->setAnimationSpeed(30);

	return node;
}


ITexture* ContentLoader::LoadTexture(const c8 *filename, IrrlichtDevice *device)
{
	stringc fn(filename), extension;
	ITexture *texture = 0;

	//Get the extension of the passed filename
	getFileNameExtension(extension, fn);
	//Convert extension to lowercase
	extension.make_lower();

	//If a texture is loaded apply it to the current model..
	if (	extension == ".jpg" || extension == ".pcx" ||
			extension == ".png" || extension == ".ppm" ||
			extension == ".pgm" || extension == ".pbm" ||
			extension == ".psd" || extension == ".tga" ||
			extension == ".bmp")
	{
		IVideoDriver *driver = device->getVideoDriver();

		//Create a texture from the filename
		texture = driver->getTexture( fn.c_str() );
		
		// always reload texture
		driver->removeTexture ( texture );
		texture = driver->getTexture( fn.c_str() );
		if(texture) printf("Texture Loaded! \n");	
	}
	return texture;	
}

Level* ContentLoader::LoadLevel(const c8 *filename, IrrlichtDevice *device)
{
	Level *level = new Level(device);
	if(level->LoadLevelFromFile(stringc(filename)) == false)
	{
		device->getGUIEnvironment()->addMessageBox(L"ToyBox",
			L"The level could not be loaded. " \
			L"Maybe it is not a supported file format.");
		return 0;
	}
	return level;
}

void ContentLoader::LoadArchive(const c8 *filename, IrrlichtDevice *device)
{
	stringc fn(filename), extension;

	//Get the extension of the passed filename
	getFileNameExtension(extension, fn);
	//Convert extension to lowercase
	extension.make_lower();

	// if a archive is loaded add it to the FileSystems..
	if (extension == ".pk3" || extension == ".zip")
		device->getFileSystem()->addZipFileArchive( fn.c_str () );
}

ContentLoader::~ContentLoader(void)
{
}
