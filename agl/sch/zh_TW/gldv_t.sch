/* 
================================================================================
檔案代號:gldv_t
檔案名稱:合併報表關係人遞延項攤銷維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gldv_t
(
gldvent       number(5)      ,/* 企業編號 */
gldvld       varchar2(5)      ,/* 合併帳別 */
gldv001       varchar2(10)      ,/* 上層公司編號 */
gldv002       varchar2(5)      ,/* 帳別 */
gldv003       number(5,0)      ,/* 年度 */
gldv004       number(5,0)      ,/* 期別 */
gldv005       varchar2(10)      ,/* 幣別(記帳幣) */
gldv006       varchar2(10)      ,/* 幣別(功能幣) */
gldv007       varchar2(10)      ,/* 幣別(報告幣) */
gldv008       varchar2(20)      ,/* 傳票單號 */
gldv009       number(10,0)      ,/* 項次 */
gldv010       varchar2(1)      ,/* 交易性質 */
gldv011       varchar2(1)      ,/* 交易類別 */
gldv012       varchar2(10)      ,/* 來源公司 */
gldv013       varchar2(5)      ,/* 來源公司帳別 */
gldv014       varchar2(10)      ,/* 交易公司 */
gldv015       varchar2(5)      ,/* 交易公司帳別 */
gldv016       varchar2(24)      ,/* 未實現損益科目 */
gldv017       varchar2(24)      ,/* 攤銷科目 */
gldv018       varchar2(24)      ,/* 費用科目 */
gldv019       number(20,6)      ,/* 分配未實現利益借方(記帳幣) */
gldv020       number(20,6)      ,/* 分配未實現利益借方(功能幣) */
gldv021       number(20,6)      ,/* 分配未實現利益借方(報告幣) */
gldv022       number(5,0)      ,/* 攤銷總期數 */
gldv023       number(5,0)      ,/* 己攤銷期數 */
gldv024       number(20,6)      ,/* 己攤銷借方金額(記帳幣) */
gldv025       number(20,6)      ,/* 己攤銷借方金額(功能幣) */
gldv026       number(20,6)      ,/* 己攤銷借方金額(報告幣) */
gldv027       number(20,6)      ,/* 分配未實現利益貸方(記帳幣) */
gldv028       number(20,6)      ,/* 分配未實現利益貸方(功能幣) */
gldv029       number(20,6)      ,/* 分配未實現利益貸方(報告幣) */
gldv030       number(20,6)      ,/* 己攤銷貸方金額(記帳幣) */
gldv031       number(20,6)      ,/* 己攤銷貸方金額(功能幣) */
gldv032       number(20,6)      ,/* 己攤銷貸方金額(報告幣) */
gldvstus       varchar2(10)      ,/* 狀態碼 */
gldvownid       varchar2(20)      ,/* 資料所有者 */
gldvowndp       varchar2(10)      ,/* 資料所屬部門 */
gldvcrtid       varchar2(20)      ,/* 資料建立者 */
gldvcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldvcrtdt       timestamp(0)      ,/* 資料創建日 */
gldvmodid       varchar2(20)      ,/* 資料修改者 */
gldvmoddt       timestamp(0)      ,/* 最近修改日 */
gldvcnfid       varchar2(20)      ,/* 資料確認者 */
gldvcnfdt       timestamp(0)      ,/* 資料確認日 */
gldvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldv_t add constraint gldv_pk primary key (gldvent,gldvld,gldv001,gldv002,gldv003,gldv004,gldv009) enable validate;

create unique index gldv_pk on gldv_t (gldvent,gldvld,gldv001,gldv002,gldv003,gldv004,gldv009);

grant select on gldv_t to tiptop;
grant update on gldv_t to tiptop;
grant delete on gldv_t to tiptop;
grant insert on gldv_t to tiptop;

exit;
