@inc/input_vars_init;
prompt *** Find object
prompt * Usage: @obj object_mask/object_id [owner] [object_type]
col owner           format a30;
col object_name     format a30;
col object_type     format a25;
col last_ddl_time   format a19;
col timestamp       format a19 trunc;

select owner,object_name,object_type,object_id ,created
   ,to_char(last_ddl_time,'yyyy-mm-dd hh24:mi:ss') last_ddl_time
   ,o.timestamp
   ,status
from dba_objects o 
where 
   (to_char(o.object_id) like '&1' or upper(object_name) like upper('&1'))
   and o.owner like nvl(upper('&2'),'%')
   and object_type like upper('%&3%')
;
col owner           clear;
col object_name     clear;
col object_type     clear;
col last_ddl_time   clear;
col timestamp       clear;
@inc/input_vars_undef;