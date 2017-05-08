/* 
================================================================================
檔案代號:bmfc_t
檔案名稱:ECN替代料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfc_t
(
bmfcent       number(5)      ,/* 企業編號 */
bmfcsite       varchar2(10)      ,/* 營運據點 */
bmfcdocno       varchar2(20)      ,/* ECN單號 */
bmfc002       number(10,0)      ,/* 項次 */
bmfc003       number(10,0)      ,/* 項次2 */
bmfc004       varchar2(10)      ,/* 變更方式 */
bmfc005       varchar2(40)      ,/* 替代料號 */
bmfc006       date      ,/* 生效日期 */
bmfc007       date      ,/* 失效日期 */
bmfc008       number(20,6)      ,/* 取替代量 */
bmfc009       number(20,6)      ,/* 元件底數 */
bmfc010       varchar2(10)      ,/* 單位 */
bmfc011       varchar2(1)      ,/* 限定客戶 */
bmfc012       number(5,0)      ,/* 優先順序 */
bmfc013       varchar2(10)      ,/* 取替代方式 */
bmfc014       number(20,6)      ,/* 替代上限比率 */
bmfc015       varchar2(256)      ,/* 產品特徵 */
bmfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfc_t add constraint bmfc_pk primary key (bmfcent,bmfcsite,bmfcdocno,bmfc002,bmfc003) enable validate;

create unique index bmfc_pk on bmfc_t (bmfcent,bmfcsite,bmfcdocno,bmfc002,bmfc003);

grant select on bmfc_t to tiptop;
grant update on bmfc_t to tiptop;
grant delete on bmfc_t to tiptop;
grant insert on bmfc_t to tiptop;

exit;
