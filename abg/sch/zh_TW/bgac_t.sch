/* 
================================================================================
檔案代號:bgac_t
檔案名稱:預算週期資料檔案
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgac_t
(
bgacent       number(5)      ,/* 企業編號 */
bgacownid       varchar2(20)      ,/* 資料所有者 */
bgacowndp       varchar2(10)      ,/* 資料所屬部門 */
bgaccrtid       varchar2(20)      ,/* 資料建立者 */
bgaccrtdp       varchar2(10)      ,/* 資料建立部門 */
bgaccrtdt       timestamp(0)      ,/* 資料創建日 */
bgacmodid       varchar2(20)      ,/* 資料修改者 */
bgacmoddt       timestamp(0)      ,/* 最近修改日 */
bgacstus       varchar2(10)      ,/* 狀態碼 */
bgac001       varchar2(5)      ,/* 預算週期編號 */
bgac002       date      ,/* 日期 */
bgac003       number(5,0)      ,/* 歸屬季別 */
bgac004       number(5,0)      ,/* 歸屬期別 */
bgac005       number(5,0)      ,/* 歸屬周別 */
bgac006       varchar2(1)      ,/* 週期種類 */
bgacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgac_t add constraint bgac_pk primary key (bgacent,bgac001,bgac002) enable validate;

create unique index bgac_pk on bgac_t (bgacent,bgac001,bgac002);

grant select on bgac_t to tiptop;
grant update on bgac_t to tiptop;
grant delete on bgac_t to tiptop;
grant insert on bgac_t to tiptop;

exit;
