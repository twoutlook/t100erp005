/* 
================================================================================
檔案代號:pmak_t
檔案名稱:一次性交易對象資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmak_t
(
pmakent       number(5)      ,/* 企業編號 */
pmak001       varchar2(20)      ,/* 交易對象識別碼 */
pmak002       varchar2(10)      ,/* 交易對象編號 */
pmak003       varchar2(500)      ,/* 全名 */
pmak004       varchar2(20)      ,/* 稅籍編號 */
pmak005       varchar2(4000)      ,/* 聯絡地址 */
pmak006       varchar2(20)      ,/* 來源單號 */
pmak007       varchar2(255)      ,/* 簡要說明 */
pmak008       date      ,/* 建檔日期 */
pmak009       varchar2(30)      ,/* 銀行帳戶 */
pmak010       varchar2(15)      ,/* 銀行別 */
pmakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmak_t add constraint pmak_pk primary key (pmakent,pmak001) enable validate;

create unique index pmak_pk on pmak_t (pmakent,pmak001);

grant select on pmak_t to tiptop;
grant update on pmak_t to tiptop;
grant delete on pmak_t to tiptop;
grant insert on pmak_t to tiptop;

exit;
