/* 
================================================================================
檔案代號:bgam_t
檔案名稱:預算週期對應檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgam_t
(
bgament       number(5)      ,/* 企業編號 */
bgam001       varchar2(10)      ,/* 預算週期編號 */
bgam002       varchar2(5)      ,/* 會計週期參照表號 */
bgam008       number(5,0)      ,/* 年度 */
bgam003       date      ,/* 預算日期 */
bgam004       number(5,0)      ,/* 對應會計週期所屬年度 */
bgam005       number(5,0)      ,/* 對應會計週期所屬季別 */
bgam006       number(5,0)      ,/* 對應會計週期所屬期別 */
bgam007       number(5,0)      ,/* 對應會計週期所屬周別 */
bgamownid       varchar2(20)      ,/* 資料所有者 */
bgamowndp       varchar2(10)      ,/* 資料所屬部門 */
bgamcrtid       varchar2(20)      ,/* 資料建立者 */
bgamcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgamcrtdt       timestamp(0)      ,/* 資料創建日 */
bgammodid       varchar2(20)      ,/* 資料修改者 */
bgammoddt       timestamp(0)      ,/* 最近修改日 */
bgamstus       varchar2(10)      ,/* 狀態碼 */
bgamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgam_t add constraint bgam_pk primary key (bgament,bgam001,bgam002,bgam003) enable validate;

create unique index bgam_pk on bgam_t (bgament,bgam001,bgam002,bgam003);

grant select on bgam_t to tiptop;
grant update on bgam_t to tiptop;
grant delete on bgam_t to tiptop;
grant insert on bgam_t to tiptop;

exit;
