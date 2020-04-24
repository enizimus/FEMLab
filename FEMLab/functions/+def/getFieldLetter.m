function fieldLetter = getFieldLetter(fieldString)

switch fieldString
    case 'Electrostatic'
        fieldLetter = 'E';
    case 'Magnetostatic'
        fieldLetter = 'B';
    case 'Stationary current'
        fieldLetter = 'J';
end