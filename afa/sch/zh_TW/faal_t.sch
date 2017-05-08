/* 
================================================================================
檔案代號:faal_t
檔案名稱:固定資產主要類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faal_t
(
faalent       number(5)      ,/* 企業編號 */
faalld       varchar2(5)      ,/* 帳套 */
faal001       varchar2(10)      ,/* 資產主要類別 */
faal002       varchar2(1)      ,/* 已停用資產是否計提折舊 */
faal003       varchar2(1)      ,/* 當月處置是否計提折舊 */
faal004       varchar2(1)      ,/* 資產處置轉入清理科目 */
faal005       number(10)      ,/* 本月入帳提列方式 */
faalownid       varchar2(20)      ,/* 資料所有者 */
faalowndp       varchar2(10)      ,/* 資料所屬部門 */
faalcrtid       varchar2(20)      ,/* 資料建立者 */
faalcrtdp       varchar2(10)      ,/* 資料建立部門 */
faalcrtdt       timestamp(0)      ,/* 資料創建日 */
faalmodid       varchar2(20)      ,/* 資料修改者 */
faalmoddt       timestamp(0)      ,/* 最近修改日 */
faalstus       varchar2(10)      ,/* 狀態碼 */
faalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faalud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
faal006       varchar2(100)      /* 列帳/列管 */
);
alter table faal_t add constraint faal_pk primary key (faalent,faalld,faal001) enable validate;

create unique index faal_pk on faal_t (faalent,faalld,faal001);

grant select on faal_t to tiptop;
grant update on faal_t to tiptop;
grant delete on faal_t to tiptop;
grant insert on faal_t to tiptop;

exit;
