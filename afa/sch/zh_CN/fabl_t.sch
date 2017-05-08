/* 
================================================================================
檔案代號:fabl_t
檔案名稱:資產合併/分割單身一明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabl_t
(
fablent       number(5)      ,/* 企業編碼 */
fablcomp       varchar2(10)      ,/* 法人 */
fabldocno       varchar2(20)      ,/* 工作量單號 */
fablseq       number(10,0)      ,/* 項次 */
fabl001       varchar2(20)      ,/* 財產編號 */
fabl002       varchar2(20)      ,/* 附號 */
fabl003       varchar2(10)      ,/* 卡片編號 */
fabl004       varchar2(10)      ,/* 主要類型 */
fabl005       varchar2(40)      ,/* 規格 */
fabl006       number(20,6)      ,/* 數量 */
fabl007       number(10)      ,/* 資產性質 */
fabl008       number(10)      ,/* 資產屬性 */
fabl009       varchar2(10)      ,/* 幣別 */
fabl010       number(20,10)      ,/* 匯率 */
fabl011       number(20,6)      ,/* 成本 */
fabl012       number(20,6)      ,/* 累折 */
fabl013       varchar2(10)      ,/* 管理組織 */
fabl014       varchar2(10)      ,/* 所有組織 */
fabl015       varchar2(10)      ,/* 核算組織 */
fabl016       number(20,6)      ,/* 未折減額 */
fabl017       number(10)      ,/* 類型 */
fabl018       number(10,0)      ,/* 使用年限 */
fabl101       varchar2(10)      ,/* 本位幣二幣別 */
fabl102       number(20,10)      ,/* 本位幣二匯率 */
fabl103       number(20,6)      ,/* 本位幣二成本 */
fabl104       number(20,6)      ,/* 本位幣二累折 */
fabl105       number(20,6)      ,/* 本位幣二未折減額 */
fabl106       number(20,6)      ,/* 本位幣二減值準備 */
fabl201       varchar2(10)      ,/* 本位幣三幣別 */
fabl202       number(20,10)      ,/* 本位幣三匯率 */
fabl203       number(20,6)      ,/* 本位幣三成本 */
fabl204       number(20,6)      ,/* 本位幣三累折 */
fabl205       number(20,6)      ,/* 本位幣三耒折減額 */
fabl206       number(20,6)      ,/* 本位幣三減值準備 */
fabl019       number(20,6)      ,/* 減值準備 */
fablud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fablud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fablud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fablud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fablud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fablud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fablud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fablud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fablud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fablud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fablud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fablud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fablud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fablud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fablud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fablud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fablud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fablud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fablud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fablud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fablud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fablud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fablud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fablud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fablud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fablud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fablud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fablud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fablud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fablud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabl_t add constraint fabl_pk primary key (fablent,fabldocno,fablseq) enable validate;

create unique index fabl_pk on fabl_t (fablent,fabldocno,fablseq);

grant select on fabl_t to tiptop;
grant update on fabl_t to tiptop;
grant delete on fabl_t to tiptop;
grant insert on fabl_t to tiptop;

exit;
