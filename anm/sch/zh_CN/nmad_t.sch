/* 
================================================================================
檔案代號:nmad_t
檔案名稱:銀行存提碼對應現金變動碼資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmad_t
(
nmadent       number(5)      ,/* 企業編號 */
nmadownid       varchar2(20)      ,/* 資料所有者 */
nmadowndp       varchar2(10)      ,/* 資料所屬部門 */
nmadcrtid       varchar2(20)      ,/* 資料建立者 */
nmadcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmadcrtdt       timestamp(0)      ,/* 資料創建日 */
nmadmodid       varchar2(20)      ,/* 資料修改者 */
nmadmoddt       timestamp(0)      ,/* 最近修改日 */
nmadstus       varchar2(1)      ,/* 狀態碼 */
nmad001       varchar2(5)      ,/* 現金變動碼表 */
nmad002       varchar2(10)      ,/* 存提碼 */
nmad003       varchar2(10)      ,/* 現金異動碼 */
nmadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmad_t add constraint nmad_pk primary key (nmadent,nmad001,nmad002) enable validate;

create unique index nmad_pk on nmad_t (nmadent,nmad001,nmad002);

grant select on nmad_t to tiptop;
grant update on nmad_t to tiptop;
grant delete on nmad_t to tiptop;
grant insert on nmad_t to tiptop;

exit;
