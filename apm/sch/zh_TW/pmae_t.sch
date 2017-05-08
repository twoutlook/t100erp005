/* 
================================================================================
檔案代號:pmae_t
檔案名稱:交易對象標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmae_t
(
pmaeent       number(5)      ,/* 企業編號 */
pmae001       varchar2(10)      ,/* 交易對象編號 */
pmae002       varchar2(10)      ,/* 標籤編號 */
pmae003       varchar2(1)      ,/* 交易對象類型 */
pmaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmae_t add constraint pmae_pk primary key (pmaeent,pmae001,pmae002,pmae003) enable validate;

create unique index pmae_pk on pmae_t (pmaeent,pmae001,pmae002,pmae003);

grant select on pmae_t to tiptop;
grant update on pmae_t to tiptop;
grant delete on pmae_t to tiptop;
grant insert on pmae_t to tiptop;

exit;
