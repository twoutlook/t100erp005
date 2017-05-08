/* 
================================================================================
檔案代號:mmby_t
檔案名稱:生效營運組織卡活動規則單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmby_t
(
mmbyent       number(5)      ,/* 企業編號 */
mmbysite       varchar2(10)      ,/* 營運據點 */
mmbyunit       varchar2(10)      ,/* 應用組織 */
mmby001       varchar2(30)      ,/* 活動規則編號 */
mmby002       varchar2(10)      ,/* 版本 */
mmby003       varchar2(1)      ,/* 活動規則說明 */
mmby004       varchar2(10)      ,/* 活動類型 */
mmby005       varchar2(10)      ,/* 規則對象編號 */
mmby006       varchar2(30)      ,/* 活動檔期編號 */
mmby007       varchar2(10)      ,/* 規則類型 */
mmby008       varchar2(10)      ,/* 排除方式 */
mmby009       varchar2(10)      ,/* 累計方式 */
mmby010       varchar2(10)      ,/* 換贈方式 */
mmby011       varchar2(10)      ,/* 規則兌換限制 */
mmby012       number(5,0)      ,/* 規則兌換次數 */
mmby013       varchar2(1)      ,/* 參加其他換贈 */
mmby014       date      ,/* 開始日期 */
mmby015       date      ,/* 結束日期 */
mmby016       timestamp(0)      ,/* 發佈日期 */
mmby017       varchar2(1)      ,/* 下級發佈 */
mmbyownid       varchar2(20)      ,/* 資料所有者 */
mmbyowndp       varchar2(10)      ,/* 資料所有部門 */
mmbycrtid       varchar2(20)      ,/* 資料建立者 */
mmbycrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbycrtdt       timestamp(0)      ,/* 資料創建日 */
mmbymodid       varchar2(20)      ,/* 資料修改者 */
mmbymoddt       timestamp(0)      ,/* 最近修改日 */
mmbycnfid       varchar2(20)      ,/* 資料確認者 */
mmbycnfdt       timestamp(0)      ,/* 資料確認日 */
mmbystus       varchar2(10)      ,/* 狀態碼 */
mmbyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbyud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmby018       varchar2(1)      ,/* 限定金額 */
mmby019       varchar2(1)      ,/* 規則對象 */
mmby020       varchar2(20)      ,/* no use */
mmbydocno       varchar2(20)      /* 單號 */
);
alter table mmby_t add constraint mmby_pk primary key (mmbyent,mmbysite,mmby001,mmby002) enable validate;

create unique index mmby_pk on mmby_t (mmbyent,mmbysite,mmby001,mmby002);

grant select on mmby_t to tiptop;
grant update on mmby_t to tiptop;
grant delete on mmby_t to tiptop;
grant insert on mmby_t to tiptop;

exit;
