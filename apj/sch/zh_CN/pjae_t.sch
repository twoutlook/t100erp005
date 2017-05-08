/* 
================================================================================
檔案代號:pjae_t
檔案名稱:專案報價明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjae_t
(
pjaeent       number(5)      ,/* 企業編號 */
pjae001       varchar2(20)      ,/* 專案編號 */
pjae002       number(10,0)      ,/* 報價版本 */
pjae003       varchar2(10)      ,/* WBS類型 */
pjae004       number(10,0)      ,/* 序號 */
pjae005       varchar2(40)      ,/* 料號 */
pjae006       varchar2(10)      ,/* 單位 */
pjae007       number(20,6)      ,/* 數量 */
pjae008       number(20,6)      ,/* 單價 */
pjae009       number(20,6)      ,/* 未稅金額 */
pjae010       number(20,6)      ,/* 含稅金額 */
pjae011       varchar2(255)      ,/* 備註 */
pjae012       varchar2(10)      ,/* 稅別 */
pjaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjaeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjae013       number(5,2)      ,/* 稅率 */
pjae014       varchar2(256)      /* 產品特徵 */
);
alter table pjae_t add constraint pjae_pk primary key (pjaeent,pjae001,pjae002,pjae003,pjae004) enable validate;

create unique index pjae_pk on pjae_t (pjaeent,pjae001,pjae002,pjae003,pjae004);

grant select on pjae_t to tiptop;
grant update on pjae_t to tiptop;
grant delete on pjae_t to tiptop;
grant insert on pjae_t to tiptop;

exit;
