/* 
================================================================================
檔案代號:psca_t
檔案名稱:APS版本資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table psca_t
(
pscaent       number(5)      ,/* 企業編號 */
pscasite       varchar2(10)      ,/* 營運據點 */
psca001       varchar2(10)      ,/* APS編號 */
psca002       varchar2(10)      ,/* 計算模式 */
psca003       varchar2(10)      ,/* 關鍵料設定 */
psca004       varchar2(10)      ,/* Hardpegging鎖定機制 */
psca005       varchar2(1)      ,/* Hardpegging可挪用 */
psca006       varchar2(10)      ,/* 手調鎖定機制 */
psca007       varchar2(1)      ,/* 手調鎖定可挪用 */
psca008       varchar2(10)      ,/* 需求單摸序模式 */
psca009       varchar2(1)      ,/* 處理取替代料 */
psca010       varchar2(1)      ,/* no use */
psca011       varchar2(1)      ,/* 取替代時主料保留 */
psca012       number(5,0)      ,/* 保留天數 */
psca013       varchar2(1)      ,/* 允許庫存批混批供給 */
psca014       varchar2(1)      ,/* 庫存無效過期不可延用 */
psca015       varchar2(10)      ,/* 產能平準方式 */
psca016       varchar2(10)      ,/* 達交策略 */
psca017       varchar2(1)      ,/* 超出嚴守交期時，壓縮非瓶頸資源的前後置時間 */
psca018       number(5,0)      ,/* no use */
psca019       varchar2(1)      ,/* 使用MDS */
psca020       varchar2(10)      ,/* MDS編號 */
psca021       varchar2(10)      ,/* 限制條件選項 */
psca022       varchar2(10)      ,/* 無製程工單虛擬製程編號 */
psca023       varchar2(10)      ,/* 無製程工單虛擬作業編號 */
psca024       varchar2(10)      ,/* 無製程工單虛擬作業序 */
psca025       varchar2(10)      ,/* 無製程工單虛擬裝置編號 */
psca026       varchar2(10)      ,/* 虛擬外包廠 */
psca027       varchar2(1)      ,/* no use */
psca028       varchar2(1)      ,/* no use */
psca029       varchar2(1)      ,/* 使用供給法則 */
psca030       varchar2(10)      ,/* 供給法則編號 */
psca031       varchar2(1)      ,/* 供給法則供給餘量可提供未指定需求 */
psca032       varchar2(10)      ,/* 產能平準區間 */
psca033       varchar2(10)      ,/* 週起點 */
psca034       number(5,0)      ,/* 工單最早開工天數 */
psca035       varchar2(10)      ,/* 參考 APS編號 */
pscaownid       varchar2(20)      ,/* 資料所有者 */
pscaowndp       varchar2(10)      ,/* 資料所屬部門 */
pscacrtid       varchar2(20)      ,/* 資料建立者 */
pscacrtdp       varchar2(10)      ,/* 資料建立部門 */
pscacrtdt       timestamp(0)      ,/* 資料創建日 */
pscamodid       varchar2(20)      ,/* 資料修改者 */
pscamoddt       timestamp(0)      ,/* 最近修改日 */
pscastus       varchar2(10)      ,/* 狀態碼 */
pscaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pscaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pscaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pscaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pscaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pscaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pscaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pscaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pscaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pscaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pscaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pscaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pscaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pscaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pscaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pscaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pscaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pscaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pscaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pscaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pscaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pscaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pscaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pscaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pscaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pscaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pscaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pscaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pscaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pscaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
psca036       varchar2(1)      ,/* 建議生產料件展下階 */
psca037       varchar2(1)      ,/* 考慮SET替代 */
psca038       varchar2(1)      ,/* 不考慮組裝協調 */
psca039       varchar2(10)      ,/* APS引擎 */
psca040       varchar2(1)      ,/* APS資料庫建立 */
psca041       varchar2(1)      ,/* 考慮保稅料 */
psca042       varchar2(1)      ,/* 保稅料只能使用保稅倉庫存 */
psca043       varchar2(10)      ,/* SET替代滿足方式 */
psca044       varchar2(1)      /* SET替代可混料 */
);
alter table psca_t add constraint psca_pk primary key (pscaent,pscasite,psca001) enable validate;

create unique index psca_pk on psca_t (pscaent,pscasite,psca001);

grant select on psca_t to tiptop;
grant update on psca_t to tiptop;
grant delete on psca_t to tiptop;
grant insert on psca_t to tiptop;

exit;
