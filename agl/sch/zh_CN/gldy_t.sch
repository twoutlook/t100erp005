/* 
================================================================================
檔案代號:gldy_t
檔案名稱:合併報表會計科目沖銷規則_核算項值設定資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldy_t
(
gldyent       number(5)      ,/* 企業代碼 */
gldy001       varchar2(10)      ,/* 公司編號(來源) */
gldy002       varchar2(5)      ,/* 合併帳別(來源) */
gldy003       varchar2(10)      ,/* 公司編號(對沖) */
gldy004       varchar2(5)      ,/* 合併帳別(對沖) */
gldy005       varchar2(10)      ,/* 上層公司(合併主體) */
gldy006       varchar2(5)      ,/* 合併帳別(合併主體) */
gldy007       number(10,0)      ,/* 沖銷組別序號 */
gldy008       varchar2(1)      ,/* 來源/對沖 */
gldy009       varchar2(24)      ,/* MULTI代號 */
gldy010       varchar2(30)      ,/* 核算項值 */
gldyownid       varchar2(20)      ,/* 資料所有者 */
gldyowndp       varchar2(10)      ,/* 資料所屬部門 */
gldycrtid       varchar2(20)      ,/* 資料建立者 */
gldycrtdp       varchar2(10)      ,/* 資料建立部門 */
gldycrtdt       timestamp(0)      ,/* 資料創建日 */
gldymodid       varchar2(20)      ,/* 資料修改者 */
gldymoddt       timestamp(0)      ,/* 最近修改日 */
gldystus       varchar2(10)      ,/* 狀態碼 */
gldyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldy_t add constraint gldy_pk primary key (gldyent,gldy001,gldy002,gldy003,gldy004,gldy005,gldy006,gldy007,gldy008,gldy009,gldy010) enable validate;

create unique index gldy_pk on gldy_t (gldyent,gldy001,gldy002,gldy003,gldy004,gldy005,gldy006,gldy007,gldy008,gldy009,gldy010);

grant select on gldy_t to tiptop;
grant update on gldy_t to tiptop;
grant delete on gldy_t to tiptop;
grant insert on gldy_t to tiptop;

exit;
