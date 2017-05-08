/* 
================================================================================
檔案代號:pmar_t
檔案名稱:供應商料件價格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmar_t
(
pmarent       number(5)      ,/* 企業編號 */
pmarsite       varchar2(10)      ,/* 營運據點 */
pmar000       varchar2(1)      ,/* 委外否 */
pmar001       varchar2(10)      ,/* 供應商編號 */
pmar002       varchar2(40)      ,/* 料件編號 */
pmar003       varchar2(256)      ,/* 產品特徵 */
pmar004       varchar2(10)      ,/* 作業編號 */
pmar005       varchar2(10)      ,/* 作業序 */
pmar006       varchar2(10)      ,/* 計價單位 */
pmar007       varchar2(10)      ,/* 計價幣別 */
pmar008       number(20,10)      ,/* 匯率 */
pmar009       varchar2(10)      ,/* 稅別 */
pmar010       varchar2(1)      ,/* 單價含稅否 */
pmar011       number(5,2)      ,/* 稅率 */
pmar012       number(20,6)      ,/* 原幣單價 */
pmar013       number(20,6)      ,/* 本幣單價 */
pmar014       varchar2(10)      ,/* 最近採購單位 */
pmar015       number(20,6)      ,/* 最近採購數量 */
pmar016       number(20,6)      ,/* 最近採購含稅金額 */
pmar017       number(20,6)      ,/* 最近採購未稅金額 */
pmar018       varchar2(20)      ,/* 參考單號 */
pmar019       date      ,/* 最近異動日期 */
pmar020       varchar2(20)      ,/* 最近異動人員 */
pmarownid       varchar2(20)      ,/* 資料所有者 */
pmarowndp       varchar2(10)      ,/* 資料所屬部門 */
pmarcrtid       varchar2(20)      ,/* 資料建立者 */
pmarcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmarcrtdt       timestamp(0)      ,/* 資料創建日 */
pmarmodid       varchar2(20)      ,/* 資料修改者 */
pmarmoddt       timestamp(0)      ,/* 最近修改日 */
pmarstus       varchar2(10)      ,/* 狀態碼 */
pmarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmar_t add constraint pmar_pk primary key (pmarent,pmarsite,pmar000,pmar001,pmar002,pmar003,pmar004,pmar005,pmar006,pmar007,pmar009) enable validate;

create unique index pmar_pk on pmar_t (pmarent,pmarsite,pmar000,pmar001,pmar002,pmar003,pmar004,pmar005,pmar006,pmar007,pmar009);

grant select on pmar_t to tiptop;
grant update on pmar_t to tiptop;
grant delete on pmar_t to tiptop;
grant insert on pmar_t to tiptop;

exit;
