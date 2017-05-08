/* 
================================================================================
檔案代號:bgab_t
檔案名稱:預算版本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgab_t
(
bgabent       number(5)      ,/* 企業編號 */
bgabstus       varchar2(10)      ,/* 狀態碼 */
bgab001       varchar2(10)      ,/* 預算編號 */
bgab002       varchar2(10)      ,/* 預算版本 */
bgab003       varchar2(1)      ,/* 可維護 */
bgabownid       varchar2(20)      ,/* 資料所有者 */
bgabowndp       varchar2(10)      ,/* 資料所屬部門 */
bgabcrtid       varchar2(20)      ,/* 資料建立者 */
bgabcrtdt       timestamp(0)      ,/* 資料創建日 */
bgabcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgabmodid       varchar2(20)      ,/* 資料修改者 */
bgabmoddt       timestamp(0)      ,/* 最近修改日 */
bgabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgab_t add constraint bgab_pk primary key (bgabent,bgab001,bgab002) enable validate;

create unique index bgab_pk on bgab_t (bgabent,bgab001,bgab002);

grant select on bgab_t to tiptop;
grant update on bgab_t to tiptop;
grant delete on bgab_t to tiptop;
grant insert on bgab_t to tiptop;

exit;
