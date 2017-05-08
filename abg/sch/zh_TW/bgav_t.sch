/* 
================================================================================
檔案代號:bgav_t
檔案名稱:預算匯率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgav_t
(
bgavent       number(5)      ,/* 企業編號 */
bgavownid       varchar2(20)      ,/* 資料所有者 */
bgavowndp       varchar2(10)      ,/* 資料所屬部門 */
bgavcrtid       varchar2(20)      ,/* 資料建立者 */
bgavcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgavcrtdt       timestamp(0)      ,/* 資料創建日 */
bgavmodid       varchar2(20)      ,/* 資料修改者 */
bgavmoddt       timestamp(0)      ,/* 最近修改日 */
bgavstus       varchar2(10)      ,/* 狀態碼 */
bgav001       varchar2(10)      ,/* 預算編號 */
bgav002       varchar2(10)      ,/* 幣別 */
bgav003       date      ,/* 日期 */
bgav004       number(20,10)      ,/* 匯率 */
bgav005       varchar2(10)      ,/* 兌換幣別 */
bgav006       varchar2(10)      ,/* 匯率輸入方式 */
bgavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgavud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bgav007       number(20,6)      ,/* 來源貨幣批量 */
bgav008       number(20,6)      /* 兌換貨幣批量 */
);
alter table bgav_t add constraint bgav_pk primary key (bgavent,bgav001,bgav002,bgav003,bgav005) enable validate;

create unique index bgav_pk on bgav_t (bgavent,bgav001,bgav002,bgav003,bgav005);

grant select on bgav_t to tiptop;
grant update on bgav_t to tiptop;
grant delete on bgav_t to tiptop;
grant insert on bgav_t to tiptop;

exit;
