import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    minLength: [4, 'Username must be at least 4 characters long']
  },
  name: {
    type: String,
    required: true,
    trim: true,
  },
  phone: {
    type: String,
    required: [true, 'Phone number is required'],
    unique: true,
    trim: true,
    validate: {
      validator: (value: string) => {
        return /^(\+91)?[6789]\d{9}$/.test(value);
      },
      message: props => `${props.value} is not a valid phone number!`
    }
  },
  email: {
    type: String,
    required: [true, 'Email is required'],
    trim: true,
    validate: {
      validator: (value: string) => {
        return /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(value);
      },
      message: props => `${props.value} is not valid!`
    }
  },
  avatar: {
    type: String,
    default: '',
  }
});

const User = mongoose.model('User', userSchema);
export default User;
