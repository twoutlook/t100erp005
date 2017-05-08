/* 
================================================================================
檔案代號:rtkh_t
檔案名稱:自動補貨補貨模型主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table rtkh_t
(
rtkhent       number(5)      ,/* 企業編號 */
rtkhunit       varchar2(10)      ,/* 應用組織 */
rtkh001       varchar2(10)      ,/* 補貨模型編號 */
rtkh002       varchar2(10)      ,/* 日均銷量DMS公式 */
rtkh003       number(20,6)      ,/* DMS昨日值佔比 */
rtkh004       number(20,6)      ,/* 促銷PDMS昨日值佔比 */
rtkh005       varchar2(10)      ,/* 建議補貨量計算公式 */
rtkh006       varchar2(1)      ,/* DM商品參與自動補貨 */
rtkh007       varchar2(1)      ,/* 其他促銷商品參與自動補貨 */
rtkh008       varchar2(1)      ,/* 一次性商品參與自動補貨 */
rtkh009       varchar2(1)      ,/* 門店對採購續訂的商品自動補貨 */
rtkh010       varchar2(1)      ,/* 無貨架資訊的商品參與自動補貨 */
rtkh011       varchar2(1)      ,/* 可手工修改自動補貨建議量 */
rtkh012       number(20,6)      ,/* 自動補貨量上限 */
rtkh013       number(20,6)      ,/* 自動補貨金額上限 */
rtkh014       number(5,0)      ,/* 自動補貨申請最大有效期(天) */
rtkhownid       varchar2(20)      ,/* 資料所有者 */
rtkhowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkhcrtid       varchar2(20)      ,/* 資料建立者 */
rtkhcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkhcrtdt       timestamp(0)      ,/* 資料創建日 */
rtkhmodid       varchar2(20)      ,/* 資料修改者 */
rtkhmoddt       timestamp(0)      ,/* 最近修改日 */
rtkhcnfid       varchar2(20)      ,/* 資料確認者 */
rtkhcnfdt       timestamp(0)      ,/* 資料確認日 */
rtkhstus       varchar2(10)      ,/* 狀態碼 */
rtkhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkh_t add constraint rtkh_pk primary key (rtkhent,rtkh001) enable validate;

create unique index rtkh_pk on rtkh_t (rtkhent,rtkh001);

grant select on rtkh_t to tiptop;
grant update on rtkh_t to tiptop;
grant delete on rtkh_t to tiptop;
grant insert on rtkh_t to tiptop;

exit;
