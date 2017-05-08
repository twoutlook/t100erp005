/* 
================================================================================
檔案代號:fabm_t
檔案名稱:資產合併/分割單身二明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabm_t
(
fabment       number(5)      ,/* 企業編碼 */
fabmcomp       varchar2(10)      ,/* 法人 */
fabmdocno       varchar2(20)      ,/* 工作量單號 */
fabmseq       number(10,0)      ,/* 項次 */
fabm001       varchar2(20)      ,/* 財產編號 */
fabm002       varchar2(20)      ,/* 附號 */
fabm003       varchar2(10)      ,/* 卡片編號 */
fabm004       varchar2(10)      ,/* 主要類型 */
fabm005       number(10)      ,/* 類型 */
fabm006       varchar2(40)      ,/* 規格 */
fabm007       number(20,6)      ,/* 數量 */
fabm008       number(10)      ,/* 資產性質 */
fabm009       number(10)      ,/* 資產屬性 */
fabm010       varchar2(10)      ,/* 幣別 */
fabm011       number(20,10)      ,/* 匯率 */
fabm012       number(20,6)      ,/* 成本 */
fabm013       number(20,6)      ,/* 累折 */
fabm014       varchar2(10)      ,/* 管理組織 */
fabm015       varchar2(10)      ,/* 所有組織 */
fabm016       varchar2(10)      ,/* 核算組織 */
fabm017       number(20,6)      ,/* 未折減額 */
fabm018       number(20,6)      ,/* 減值準備 */
fabm101       varchar2(10)      ,/* 本位幣二幣別 */
fabm102       number(20,10)      ,/* 本位幣二匯率 */
fabm103       number(20,6)      ,/* 本位幣二成本 */
fabm104       number(20,6)      ,/* 本位幣二累折 */
fabm105       number(20,6)      ,/* 本位幣二未折減額 */
fabm106       number(20,6)      ,/* 本位幣二減值準備 */
fabm201       varchar2(10)      ,/* 本位幣三幣別 */
fabm202       number(20,10)      ,/* 本位幣三匯率 */
fabm203       number(20,6)      ,/* 本位幣三成本 */
fabm204       number(20,6)      ,/* 本位幣三累折 */
fabm205       number(20,6)      ,/* 本位幣三未折減額 */
fabm206       number(20,6)      ,/* 本位幣三減值準備 */
fabm019       number(10,0)      ,/* 使用年限 */
fabmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabm_t add constraint fabm_pk primary key (fabment,fabmdocno,fabmseq) enable validate;

create unique index fabm_pk on fabm_t (fabment,fabmdocno,fabmseq);

grant select on fabm_t to tiptop;
grant update on fabm_t to tiptop;
grant delete on fabm_t to tiptop;
grant insert on fabm_t to tiptop;

exit;
