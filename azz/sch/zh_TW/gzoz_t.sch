/* 
================================================================================
檔案代號:gzoz_t
檔案名稱:系統字詞典檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzoz_t
(
gzozstus       varchar2(10)      ,/* 狀態碼 */
gzozownid       varchar2(20)      ,/* 資料所有者 */
gzozowndp       varchar2(10)      ,/* 資料所屬部門 */
gzozcrtid       varchar2(20)      ,/* 資料建立者 */
gzozcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzozcrtdt       timestamp(0)      ,/* 資料創建日 */
gzozmodid       varchar2(20)      ,/* 資料修改者 */
gzozmoddt       timestamp(0)      ,/* 最近修改日 */
gzoz000       varchar2(500)      ,/* 正體中文 */
gzoz500       varchar2(1)      ,/* 整句否 */
gzoz501       varchar2(20)      ,/* 來源程式 */
gzoz502       varchar2(80)      ,/* 備註 */
gzoz001       varchar2(500)      ,/* English */
gzoz101       varchar2(1)      ,/* 英文狀態 */
gzoz201       varchar2(20)      ,/* 英文異動員工 */
gzoz301       timestamp(0)      ,/* 英文異動日期 */
gzoz002       varchar2(500)      ,/* 簡體中文 */
gzoz102       varchar2(1)      ,/* 簡體中文狀態 */
gzoz202       varchar2(20)      ,/* 簡體異動員工 */
gzoz302       timestamp(0)      ,/* 簡體異動日期 */
gzoz003       varchar2(500)      ,/* 日文 */
gzoz103       varchar2(1)      ,/* 日文狀態 */
gzoz203       varchar2(20)      ,/* 日文異動員工 */
gzoz303       timestamp(0)      ,/* 日文異動日期 */
gzoz004       varchar2(500)      ,/* 越文 */
gzoz104       varchar2(1)      ,/* 越文狀態 */
gzoz204       varchar2(20)      ,/* 越文異動員工 */
gzoz304       timestamp(0)      ,/* 越文異動日期 */
gzoz005       varchar2(500)      ,/* 泰文 */
gzoz105       varchar2(1)      ,/* 泰文狀態 */
gzoz205       varchar2(20)      ,/* 泰文異動員工 */
gzoz305       timestamp(0)      ,/* 泰文異動日期 */
gzoz006       varchar2(500)      ,/* 韓文 */
gzoz106       varchar2(1)      ,/* 韓文狀態 */
gzoz206       varchar2(20)      ,/* 韓文異動員工 */
gzoz306       timestamp(0)      ,/* 韓文異動日期 */
gzozud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzozud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzozud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzozud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzozud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzozud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzozud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzozud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzozud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzozud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzozud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzozud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzozud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzozud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzozud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzozud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzozud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzozud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzozud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzozud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzozud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzozud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzozud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzozud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzozud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzozud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzozud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzozud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzozud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzozud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzoz503       varchar2(1)      /* 英數或標點註記 */
);
alter table gzoz_t add constraint gzoz_pk primary key (gzoz000) enable validate;

create unique index gzoz_pk on gzoz_t (gzoz000);

grant select on gzoz_t to tiptop;
grant update on gzoz_t to tiptop;
grant delete on gzoz_t to tiptop;
grant insert on gzoz_t to tiptop;

exit;
