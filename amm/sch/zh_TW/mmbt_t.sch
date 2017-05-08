/* 
================================================================================
檔案代號:mmbt_t
檔案名稱:卡活動規則單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmbt_t
(
mmbtent       number(5)      ,/* 企業編號 */
mmbtunit       varchar2(10)      ,/* 應用組織 */
mmbt001       varchar2(30)      ,/* 活動規則編號 */
mmbt002       varchar2(10)      ,/* 版本 */
mmbt003       varchar2(80)      ,/* 活動說明 */
mmbt004       varchar2(1)      ,/* 活動類型 */
mmbt005       varchar2(10)      ,/* 規則對象編號 */
mmbt006       varchar2(30)      ,/* 活動檔期編號 */
mmbt007       varchar2(10)      ,/* 規則類型 */
mmbt008       varchar2(10)      ,/* 排除方式 */
mmbt009       varchar2(10)      ,/* 累計方式 */
mmbt010       varchar2(10)      ,/* 換贈方式 */
mmbt011       varchar2(10)      ,/* 規則兌換限制 */
mmbt012       number(5,0)      ,/* 規則兌換次數 */
mmbt013       varchar2(1)      ,/* 參加其他換贈 */
mmbt014       date      ,/* 開始日期 */
mmbt015       date      ,/* 結束日期 */
mmbt016       timestamp(0)      ,/* 發佈日期 */
mmbt017       varchar2(1)      ,/* 下級發佈 */
mmbtownid       varchar2(20)      ,/* 資料所有者 */
mmbtowndp       varchar2(10)      ,/* 資料所有部門 */
mmbtcrtid       varchar2(20)      ,/* 資料建立者 */
mmbtcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbtcrtdt       timestamp(0)      ,/* 資料創建日 */
mmbtmodid       varchar2(20)      ,/* 資料修改者 */
mmbtmoddt       timestamp(0)      ,/* 最近修改日 */
mmbtcnfid       varchar2(20)      ,/* 資料確認者 */
mmbtcnfdt       timestamp(0)      ,/* 資料確認日 */
mmbtstus       varchar2(10)      ,/* 狀態碼 */
mmbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbtud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmbt018       varchar2(1)      ,/* 限定金額 */
mmbt019       varchar2(10)      ,/* 規則對象 */
mmbt020       varchar2(20)      ,/* no use */
mmbtdocno       varchar2(20)      ,/* 單號 */
mmbt021       number(20,6)      ,/* 單筆限額 */
mmbt022       number(20,6)      ,/* 活動限額 */
mmbt023       number(5,0)      ,/* 人數限制 */
mmbt024       varchar2(1)      /* 依業態設定換贈規則 */
);
alter table mmbt_t add constraint mmbt_pk primary key (mmbtent,mmbt001) enable validate;

create unique index mmbt_pk on mmbt_t (mmbtent,mmbt001);

grant select on mmbt_t to tiptop;
grant update on mmbt_t to tiptop;
grant delete on mmbt_t to tiptop;
grant insert on mmbt_t to tiptop;

exit;
