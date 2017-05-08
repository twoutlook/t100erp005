/* 
================================================================================
檔案代號:faad_t
檔案名稱:固定資產次要類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faad_t
(
faadent       number(5)      ,/* 企業編號 */
faad001       varchar2(10)      ,/* 次要類型編號 */
faadownid       varchar2(20)      ,/* 資料所有者 */
faadowndp       varchar2(10)      ,/* 資料所屬部門 */
faadcrtid       varchar2(20)      ,/* 資料建立者 */
faadcrtdp       varchar2(10)      ,/* 資料建立部門 */
faadcrtdt       timestamp(0)      ,/* 資料創建日 */
faadmodid       varchar2(20)      ,/* 資料修改者 */
faadmoddt       timestamp(0)      ,/* 最近修改日 */
faadstus       varchar2(10)      ,/* 狀態碼 */
faadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faadud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
faad002       varchar2(10)      /* 歸屬主要類型 */
);
alter table faad_t add constraint faad_pk primary key (faadent,faad001) enable validate;

create unique index faad_pk on faad_t (faadent,faad001);

grant select on faad_t to tiptop;
grant update on faad_t to tiptop;
grant delete on faad_t to tiptop;
grant insert on faad_t to tiptop;

exit;
