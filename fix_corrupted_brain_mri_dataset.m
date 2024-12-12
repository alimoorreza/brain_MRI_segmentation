% ------------ CLEAN DIRECTORIES --------------
src_path         = '/Users/reza/Downloads/Brain_MRI/MRI_dataset_corrupted/';
dst_path         = '/Users/reza/Downloads/Brain_MRI/MRI_dataset/';
output_dir      = [dst_path '/training/images' ];
if ~isfolder(output_dir )
    mkdir(output_dir)
end
output_dir      = [dst_path '/training/masks' ];
if ~isfolder(output_dir )
    mkdir(output_dir)
end

output_dir      = [dst_path '/validation/images' ];
if ~isfolder(output_dir )
    mkdir(output_dir)
end
output_dir      = [dst_path '/validation/masks' ];
if ~isfolder(output_dir )
    mkdir(output_dir)
end


% ------------ COPY FILES --------------

copy_correct_files(src_path, dst_path, 'training');
copy_correct_files(src_path, dst_path, 'validation');


function copy_correct_files(src_path, dst_path, split_name)

    image_files                   = dir([src_path '/' split_name '/images/*.tif']);
    mask_files                    = dir([src_path '/' split_name '/masks/*.tif']);
    mask_files_cell_array    = {mask_files.name};
    total_files                      = length(image_files);
    counter_missing           = 1;
    for ii=1:total_files
    
        cur_image_name = image_files(ii).name;
    
        if ismember([cur_image_name(1:end-4) '_mask.tif'], mask_files_cell_array)
            % disp([num2str(ii) '/' num2str(total_files) ': ' cur_image_name ' exists in masks directory.']);
    
            copyfile([src_path  '/' split_name '/images/' cur_image_name ], [dst_path '/training/images/'], 'f');
            copyfile([src_path  '/' split_name  '/masks/' cur_image_name(1:end-4) '_mask.tif' ], [dst_path '/training/masks/'], 'f');
    
        else
            disp([num2str(ii) '/' num2str(total_files) ': ' cur_image_name ' DOESNT exist in masks directory.']);
            counter_missing = counter_missing + 1;
        end    
    
    end
    
    disp([num2str(counter_missing) '/' num2str(total_files) ' were missing']);

end

































