/* 
================================================================================
檔案代號:prdw_t
檔案名稱:促銷規則清單資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prdw_t
(
prdwent       number(5)      ,/* 企業編號 */
prdwunit       varchar2(10)      ,/* 應用組織 */
prdwsite       varchar2(10)      ,/* 營運據點 */
prdw001       varchar2(20)      ,/* 規則編號 */
prdw002       varchar2(10)      ,/* 規則版本 */
prdw003       varchar2(10)      ,/* 規則類型 */
prdw004       varchar2(20)      ,/* 申請人員 */
prdw005       varchar2(10)      ,/* 申請部門 */
prdw006       varchar2(30)      ,/* 促銷方案 */
prdw007       varchar2(30)      ,/* 活動計劃 */
prdw008       varchar2(10)      ,/* 檔期類型 */
prdw009       varchar2(10)      ,/* 活動等級 */
prdw010       varchar2(1)      ,/* 全場促銷 */
prdw011       varchar2(1)      ,/* 款別限制 */
prdw012       varchar2(1)      ,/* 折扣卡 */
prdw013       varchar2(1)      ,/* 日期高階設定 */
prdw014       number(10,0)      ,/* 組合總額/量 */
prdw015       varchar2(1)      ,/* 滿額分段否 */
prdw016       varchar2(1)      ,/* 參與換贈 */
prdw017       varchar2(10)      ,/* 換贈方式 */
prdw018       varchar2(10)      ,/* 計算方式 */
prdw019       varchar2(1)      ,/* 換贈設定模式 */
prdw020       varchar2(1)      ,/* 兼容換贈 */
prdw021       varchar2(10)      ,/* 換贈商品條件 */
prdw022       number(5,0)      ,/* 限定換贈種類 */
prdw023       number(5,0)      ,/* 限定換贈總數 */
prdw024       varchar2(10)      ,/* 促銷方式 */
prdw025       varchar2(10)      ,/* 入機方式 */
prdw026       varchar2(10)      ,/* 參與對象 */
prdw027       varchar2(40)      ,/* 促銷優先級 */
prdw028       varchar2(10)      ,/* 返利標準 */
prdw029       number(20,6)      ,/* 達成任務量返利率 */
prdw030       number(20,6)      ,/* 超出任務量返利率 */
prdw031       number(20,6)      ,/* 承擔比例 */
prdw032       varchar2(10)      ,/* 物返方式 */
prdw098       varchar2(10)      ,/* 應用業態 */
prdw099       varchar2(1)      ,/* 發佈否 */
prdw100       timestamp(0)      ,/* 發佈日期 */
prdwstus       varchar2(10)      ,/* 狀態碼 */
prdwstamp       timestamp(5)      ,/* 時間戳記 */
prdwownid       varchar2(20)      ,/* 資料所有者 */
prdwowndp       varchar2(10)      ,/* 資料所有部門 */
prdwcrtid       varchar2(20)      ,/* 資料建立者 */
prdwcrtdp       varchar2(10)      ,/* 資料建立部門 */
prdwcrtdt       timestamp(0)      ,/* 資料創建日 */
prdwmodid       varchar2(20)      ,/* 資料修改者 */
prdwmoddt       timestamp(0)      ,/* 最近修改日 */
prdwcnfid       varchar2(20)      ,/* 資料確認者 */
prdwcnfdt       timestamp(0)      ,/* 資料確認日 */
prdwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdwud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdw033       varchar2(10)      ,/* 活動類型 */
prdw034       varchar2(1)      ,/* 是否打印 */
prdw035       varchar2(10)      ,/* 專櫃促銷方式 */
prdw036       varchar2(1)      ,/* 相同基數取最低 */
prdw101       varchar2(10)      ,/* 來源類型 */
prdw102       varchar2(20)      ,/* 來源單號 */
prdwdocno       varchar2(20)      ,/* 單號 */
prdw037       number(5,0)      ,/* 會員總達成次數 */
prdw038       varchar2(1)      ,/* 疊加否 */
prdw103       varchar2(10)      /* 來源程式 */
);
alter table prdw_t add constraint prdw_pk primary key (prdwent,prdwsite,prdw001) enable validate;

create unique index prdw_pk on prdw_t (prdwent,prdwsite,prdw001);

grant select on prdw_t to tiptop;
grant update on prdw_t to tiptop;
grant delete on prdw_t to tiptop;
grant insert on prdw_t to tiptop;

exit;
