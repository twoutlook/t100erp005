/* 
================================================================================
檔案代號:fmae_t
檔案名稱:融資合約附加條款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmae_t
(
fmaeent       number(5)      ,/* 企業編號 */
fmae001       varchar2(20)      ,/* 融資合約編號 */
fmae002       number(10,0)      ,/* 項次 */
fmae003       varchar2(500)      ,/* 條款內容 */
fmae004       varchar2(80)      ,/* 說明 */
fmaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmae_t add constraint fmae_pk primary key (fmaeent,fmae001,fmae002) enable validate;

create unique index fmae_pk on fmae_t (fmaeent,fmae001,fmae002);

grant select on fmae_t to tiptop;
grant update on fmae_t to tiptop;
grant delete on fmae_t to tiptop;
grant insert on fmae_t to tiptop;

exit;
