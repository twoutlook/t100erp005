/* 
================================================================================
檔案代號:stan_t
檔案名稱:自營合約主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stan_t
(
stanent       number(5)      ,/* 企業編號 */
stanunit       varchar2(10)      ,/* 應用組織 */
stan001       varchar2(20)      ,/* 合約編號 */
stan002       varchar2(10)      ,/* 經營方式 */
stan003       varchar2(10)      ,/* 版本 */
stan004       varchar2(10)      ,/* 模板編號 */
stan005       varchar2(10)      ,/* 供應商編號 */
stan006       varchar2(10)      ,/* 幣別 */
stan007       varchar2(10)      ,/* 稅別 */
stan008       varchar2(10)      ,/* 收付款方式 */
stan009       varchar2(10)      ,/* 結算方式 */
stan010       varchar2(10)      ,/* 結算類別 */
stan011       varchar2(1)      ,/* 訂貨滿足率 */
stan012       date      ,/* 簽訂日期 */
stan013       varchar2(10)      ,/* 簽訂法人 */
stan014       varchar2(20)      ,/* 簽訂人員 */
stan015       varchar2(10)      ,/* 結算中心 */
stan016       varchar2(10)      ,/* 採購中心 */
stan017       date      ,/* 生效日期 */
stan018       date      ,/* 失效日期 */
stan019       date      ,/* 清退日期 */
stan020       date      ,/* 作廢日期 */
stan021       varchar2(20)      ,/* 文檔編號 */
stanownid       varchar2(20)      ,/* 資料所有者 */
stanowndp       varchar2(10)      ,/* 資料所有部門 */
stancrtid       varchar2(20)      ,/* 資料建立者 */
stancrtdp       varchar2(10)      ,/* 資料建立部門 */
stancrtdt       timestamp(0)      ,/* 資料創建日 */
stanmodid       varchar2(20)      ,/* 資料修改者 */
stanmoddt       timestamp(0)      ,/* 最近修改日 */
stanstus       varchar2(10)      ,/* 狀態碼 */
stancnfid       varchar2(20)      ,/* 資料確認者 */
stancnfdt       timestamp(0)      ,/* 資料確認日 */
stanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stanud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stan022       varchar2(10)      ,/* 交易條件 */
stan023       varchar2(2)      ,/* 發票類型 */
stan024       varchar2(1)      ,/* 採購價格允許人工修改 */
stan025       number(20,6)      ,/* 修改容差率 */
stan026       varchar2(10)      ,/* 超出處理方式 */
stan027       varchar2(10)      ,/* 內外購 */
stan028       varchar2(10)      ,/* 匯率計算基準 */
stan029       varchar2(10)      ,/* 合約狀態 */
stan030       varchar2(20)      ,/* 原合約編號 */
stan031       date      ,/* 延期日期 */
stan032       varchar2(10)      ,/* 收銀方式 */
stan033       date      ,/* 續期日期 */
stan034       varchar2(1)      ,/* 文本盖章否 */
stan035       date      ,/* 蓋章日期 */
stan036       varchar2(255)      ,/* 備註 */
stan037       varchar2(1)      ,/* 含發票否 */
stan038       varchar2(10)      ,/* 部門 */
stan039       varchar2(1)      /* 按法人結算 */
);
alter table stan_t add constraint stan_pk primary key (stanent,stan001) enable validate;

create unique index stan_pk on stan_t (stanent,stan001);

grant select on stan_t to tiptop;
grant update on stan_t to tiptop;
grant delete on stan_t to tiptop;
grant insert on stan_t to tiptop;

exit;
