/* 
================================================================================
檔案代號:fabn_t
檔案名稱:資產資本化單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabn_t
(
fabnent       number(5)      ,/* 企業編碼 */
fabncomp       varchar2(10)      ,/* 法人 */
fabndocno       varchar2(20)      ,/* 單據編號 */
fabnseq       number(10,0)      ,/* 項次 */
fabn001       varchar2(20)      ,/* 財產編號 */
fabn002       varchar2(20)      ,/* 附號 */
fabn003       varchar2(10)      ,/* 卡片編號 */
fabn004       varchar2(20)      ,/* 正式財產編號 */
fabn005       varchar2(20)      ,/* 正式附號 */
fabn006       date      ,/* 計提日期 */
fabn007       varchar2(10)      ,/* 幣別 */
fabn008       number(20,10)      ,/* 匯率 */
fabn009       number(20,6)      ,/* 原幣金額 */
fabn010       number(20,6)      ,/* 本幣金額 */
fabn011       varchar2(20)      ,/* 保管人員 */
fabn012       varchar2(10)      ,/* 保管部門 */
fabn013       varchar2(10)      ,/* 存放位置 */
fabn014       varchar2(10)      ,/* 管理組織 */
fabn015       varchar2(10)      ,/* 所有組織 */
fabn016       varchar2(10)      ,/* 核算組織 */
fabn017       varchar2(10)      ,/* 原因碼 */
fabnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabnud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fabn018       varchar2(10)      /* 正式卡片編號 */
);
alter table fabn_t add constraint fabn_pk primary key (fabnent,fabndocno,fabnseq) enable validate;

create unique index fabn_pk on fabn_t (fabnent,fabndocno,fabnseq);

grant select on fabn_t to tiptop;
grant update on fabn_t to tiptop;
grant delete on fabn_t to tiptop;
grant insert on fabn_t to tiptop;

exit;
