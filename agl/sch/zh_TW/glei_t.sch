/* 
================================================================================
檔案代號:glei_t
檔案名稱:合併現金流量表現金變動碼資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glei_t
(
gleient       number(5)      ,/* 企業編號 */
glei001       varchar2(5)      ,/* 群組參照表碼 */
glei002       varchar2(10)      ,/* 群組編號 */
glei003       varchar2(1)      ,/* 變動分類 */
glei004       number(10,0)      ,/* 行序 */
gleiownid       varchar2(20)      ,/* 資料所有者 */
gleiowndp       varchar2(10)      ,/* 資料所屬部門 */
gleicrtid       varchar2(20)      ,/* 資料建立者 */
gleicrtdp       varchar2(10)      ,/* 資料建立部門 */
gleicrtdt       timestamp(0)      ,/* 資料創建日 */
gleimodid       varchar2(20)      ,/* 資料修改者 */
gleimoddt       timestamp(0)      ,/* 最近修改日 */
gleistus       varchar2(10)      ,/* 狀態碼 */
gleiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gleiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gleiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gleiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gleiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gleiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gleiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gleiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gleiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gleiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gleiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gleiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gleiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gleiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gleiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gleiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gleiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gleiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gleiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gleiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gleiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gleiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gleiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gleiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gleiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gleiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gleiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gleiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gleiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gleiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glei_t add constraint glei_pk primary key (gleient,glei001,glei002) enable validate;

create unique index glei_pk on glei_t (gleient,glei001,glei002);

grant select on glei_t to tiptop;
grant update on glei_t to tiptop;
grant delete on glei_t to tiptop;
grant insert on glei_t to tiptop;

exit;
