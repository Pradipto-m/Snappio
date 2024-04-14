import multer from 'multer';

const storage = multer.memoryStorage();

const uploader = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5,
  },
  fileFilter: (req, file, cb) => {
    if (file.mimetype.match(/\/(jpg|jpeg|png)$/)) {
      cb(null, true);
    } else {
      cb(new Error('File format not supported'));
    }
  },
}).single('file');

export default uploader;