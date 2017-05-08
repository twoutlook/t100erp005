/* 
================================================================================
檔案代號:bmad_t
檔案名稱:產品結構多產出主件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmad_t
(
bmadent       number(5)      ,/* 企業編號 */
bmadsite       varchar2(10)      ,/* 營運據點 */
bmad001       varchar2(40)      ,/* 主件料號 */
bmad002       varchar2(30)      ,/* 特性 */
bmad003       varchar2(40)      ,/* 多產出主件料號 */
bmad004       number(20,6)      ,/* 產出數量 */
bmad005       varchar2(10)      ,/* 產出單位 */
bmad006       date      ,/* 生效日期 */
bmad007       date      ,/* 失效日期 */
bmadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmad_t add constraint bmad_pk primary key (bmadent,bmadsite,bmad001,bmad002,bmad003) enable validate;

create  index bmad_01 on bmad_t (bmad001,bmad002,bmad003);
create unique index bmad_pk on bmad_t (bmadent,bmadsite,bmad001,bmad002,bmad003);

grant select on bmad_t to tiptop;
grant update on bmad_t to tiptop;
grant delete on bmad_t to tiptop;
grant insert on bmad_t to tiptop;

exit;
